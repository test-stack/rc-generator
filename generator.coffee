moment = require 'moment'

rcTypes =
  official: 'OFFICIAL'
  common: 'COMMON'

genders =
  female: 'FEMALE'
  male: 'MALE'

getRandomIntInclusive = (min, max) ->
  min = Math.ceil(min)
  max = Math.floor(max)
  Math.floor(Math.random() * (max - min + 1)) + min

getGenderAddition = (byDate, gender, rcType) ->
  if (rcType is rcTypes.official && moment(byDate).format('YYYY') >= 2004 && getRandomIntInclusive(0,10) is 0)
    if (gender is genders.female)
      return 70
    return 20
  else if (gender is genders.female)
    return 50
  0

generateRc = (byDate, gender, rcType)->
  shortYear = moment(byDate).format 'YY'
  additionMonth = getGenderAddition(byDate, gender, rcType)
  month = if additionMonth > 0 then additionMonth + parseInt(moment(byDate).format('MM')) else moment(byDate).format('MM')
  rc = "#{(moment(byDate).format 'YY')}#{month}#{moment(byDate).format 'DD'}#{getRandomIntInclusive(100,999)}"
  mod = rc % 11
  rc += if mod is 10 then 0 else mod
  rc

getRC = (byDate, gender, rcType) ->
  rc = generateRc byDate, gender, rcType
  if rcType is rcTypes.common
    if rc % 11 > 0 then console.log("-- #{rc}"); generateRc(byDate, gender, rcType) else return rc
  rc

for name in [0...5]
  console.log getRC moment('20040519'), genders.female, rcTypes.common
