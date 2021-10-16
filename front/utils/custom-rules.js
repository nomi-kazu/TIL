const validTime = {
  params: ['otherValue'],
  validate (value, { otherValue }) {
    return !(value === '0' && otherValue === '0')
  },
  message () {
    return '時間は1分以上でなければ記録できません'
  }
}

const validDate = {
  params: ['minutes', 'date'],
  validate (hours, { minutes, date }) {
    const day = date.replace(/-/g, '/')
    const dateTime = new Date(`${day} ${hours}:${minutes}`)
    return dateTime <= new Date()
  },
  message () {
    return '未来の時刻は選択できません'
  }
}

// エラーメッセージを表示するため
const validDateMinutes = {
  params: ['hours', 'date'],
  validate (minutes, { hours, date }) {
    const day = date.replace(/-/g, '/')
    const dateTime = new Date(`${day} ${hours}:${minutes}`)
    return dateTime <= new Date()
  },
  message () {
    return '未来の時刻は選択できません'
  }
}

export { validTime, validDate, validDateMinutes }
