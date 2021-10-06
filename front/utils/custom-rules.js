const validTime = {
  params: ['otherValue'],

  validate (value, { otherValue }) {
    return !(value === '0' && otherValue === '0')
  },

  message () {
    return '時間は1分以上でなければ記録できません'
  }
}

export { validTime }
