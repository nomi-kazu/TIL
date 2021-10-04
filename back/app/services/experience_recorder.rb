class ExperienceRecorder
  delegate :experience, to: :@user

  def initialize(user)
    @user = user
  end

  def record(post)
    gain_exp = cal_exp(post)

    experience_record = find_or_build(post, gain_exp)

    if experience_record.persisted?
      experience_record = update_record(experience_record, gain_exp)
      down_check = true
    end

    if experience_record.save!
      experience.total += gain_exp
      check_level_down if down_check
      check_level
      experience.save!
      experience_record
    end
  end

  def delete_record(post)
    experience_record = post.experience_record
    exp = experience_record.obtained_exp
    @user.experience.total -= exp
    check_level_down
    check_level
    experience_record.destroy!
  end

  private

  def cal_exp(post)
    hours = post.study_time.hour
    minutes = post.study_time.min
    gain_exp = hours * 60 + minutes
  end

  def find_or_build(post, gain_exp)
    ExperienceRecord.find_by(post_id: post.id) ||
    @user.experience_records.build(
      obtained_exp: gain_exp,
      post_id: post.id
    )
  end

  def update_record(experience_record, gain_exp)
    old_exp = experience_record.obtained_exp
    @user.experience.total -= old_exp
    @user.experience.to_next -= old_exp
    experience_record.obtained_exp = gain_exp
    experience_record
  end

  def check_level
    required = RequiredExp.find_by(level: experience.level)
    sub_total = required.lifelong_exp - experience.total
    if sub_total <= 0
      @user.experience.level += 1
      check_level
    else
      @user.experience.to_next = sub_total
    end
  end

  def check_level_down
    required = RequiredExp.find_by(level: @user.experience.level - 1)
    if required
      sub_total = required.lifelong_exp - @user.experience.total
      if sub_total >= 0
        @user.experience.level -= 1
        check_level_down
      end
    end
  end
end