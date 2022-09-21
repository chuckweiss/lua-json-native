describe(
  'decode',
  function()
    local decode = require 'lua-json-native'.decode

    it(
      'should decode an array with object',
      function()
        local obj =
          [===[
[
  {
    "_id": "5973782bdb9a930533b05cb2\n",
    "is\"Active\"": true,
    "balance": "$1,446.35",
    "age\n": 32,
    "elements":["heating","heating_bake"],
    "eyeColor": "green",
    "name": "Logan Keller",
    "gender": "male",
    "company": "ARTIQ",
    "email": "logankeller@artiq.com",
    "phone": "+1 (952) 533-2258",
    "friends": [
      {
        "id": 0,
        "name": "Colon Salazar"
      },
      {
        "id": 1,
        "name": "French Mcneil"
      },
      {
        "id": 2,
        "name": "Carol Martin"
      }
    ],
    "favoriteFruit": "banana"
  }
]
        ]===]

        local expected = {
          {
            ['_id'] = '5973782bdb9a930533b05cb2\n',
            ['is"Active"'] = true,
            ['balance'] = '$1,446.35',
            ['age\n'] = 32,
            ['elements'] = {'heating', 'heating_bake'},
            ['eyeColor'] = 'green',
            ['name'] = 'Logan Keller',
            ['gender'] = 'male',
            ['company'] = 'ARTIQ',
            ['email'] = 'logankeller@artiq.com',
            ['phone'] = '+1 (952) 533-2258',
            ['friends'] = {
              {
                ['id'] = 0,
                ['name'] = 'Colon Salazar'
              },
              {
                ['id'] = 1,
                ['name'] = 'French Mcneil'
              },
              {
                ['id'] = 2,
                ['name'] = 'Carol Martin'
              }
            },
            ['favoriteFruit'] = 'banana'
          }
        }

        local actual = decode(obj)

        assert.are.same(expected, actual)
      end
    )

    it(
      'should decode an object with null',
      function()
        local obj = [===[
{
  "_id": null
}
        ]===]

        local expected = {}

        local actual = decode(obj)

        assert.are.same(expected, actual)
      end
    )

    it(
      'should decode an object with escaped chars',
      function()
        local obj = [===[
{
  "\"_id\n\\": "\n5973782bdb9a930533b05cb2\\"
}
        ]===]

        local expected = {
          ['"_id\n\\'] = '\n5973782bdb9a930533b05cb2\\'
        }

        local actual = decode(obj)

        assert.are.same(expected, actual)
      end
    )
  end
)
