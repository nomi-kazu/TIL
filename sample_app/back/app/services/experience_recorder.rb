# 経験値に関する計算を行い、保存する
class ExperienceRecorder
  delegate :experience, to: :@user

  def initialize(user)
    @user = user
  end

  # 学習記録の経験値を計算して保存
  def record(post)
    gain_exp = cal_exp(post)

    experience_record = find_or_build(post, gain_exp)

    # 既にtime_reportの経験値計算が終わっていた場合 (update or destroy)
    if experience_record.persisted?
      experience_record = update_record(experience_record, gain_exp)
      down_check = true # 経験値が減っている可能性があることを示す
    end

    if experience_record.save!
      experience.total += gain_exp
      check_level_down if down_check
      check_level
      experience.save!
      experience_record # return
    end
  end

  # 学習記録が削除されたときに経験値を減らす
  def delete_record(post)
    experience_record = post.experience_record
    exp = experience_record.obtained_exp
    @user.experience.total -= exp
    check_level_down
    check_level
    experience.save!
    experience_record.destroy!
  end

  private

  # 経験値を計算
  # 1分につき, 1exp
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

  # experience_recordを更新
  def update_record(experience_record, gain_exp)
    old_exp = experience_record.obtained_exp
    @user.experience.total -= old_exp
    @user.experience.to_next -= old_exp
    experience_record.obtained_exp = gain_exp
    experience_record
  end

  # レベルアップの計算
  # 獲得した経験値からレベルアップに必要な経験値を引いていく
  def check_level
    required = RequiredExp.find_by(level: experience.level)
    # 次のレベルに必要な経験値 - 獲得した総経験値
    sub_total = required.lifelong_exp - experience.total
    # 300を上限とする
    if experience.level < 299
      if sub_total <= 0
        experience.level += 1
        check_level # 再帰的に処理
      else
        experience.to_next = sub_total
      end
    elsif experience.level == 299
      if sub_total <= 0
        experience.level += 1
        experience.to_next = 0
      else
        experience.to_next = sub_total
      end
    end
  end

  # レベルを下げる処理
  def check_level_down
    required = RequiredExp.find_by(level: experience.level - 1)
    if required
      sub_total = required.lifelong_exp - experience.total
      if sub_total >= 0
        experience.level -= 1
        check_level_down
      end
    end
  end
end