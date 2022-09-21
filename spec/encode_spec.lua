describe(
  'encode',
  function()
    local encode = require 'lua-json-native'.encode

    it(
      'should encode an array with object',
      function()
        local expected =
          [===[[
  {
    "_id\n": "5973782bdb9a930533b05cb2",
    "age": 32,
    "balance": "$1,446.35",
    "company": "ARTIQ",
    "email": "logankeller@artiq.com",
    "eyeColor": "green",
    "favoriteFruit": "banana",
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
    "gender": [],
    "isActive": true,
    "name": "Logan Keller",
    "phone": "+1 (952) 533-2258"
  }
]
]===]

        local obj = {
          {
            ['_id\n'] = '5973782bdb9a930533b05cb2',
            ['isActive'] = true,
            ['balance'] = '$1,446.35',
            ['age'] = 32,
            ['eyeColor'] = 'green',
            ['name'] = 'Logan Keller',
            ['gender'] = {},
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

        local actual = encode(obj, {sort_keys = true, pretty = true})
        assert.are.same(expected, actual)
      end
    )

    it(
      'should encode an empty obj',
      function()
        local expected = '[]\n'

        local obj = {}

        local actual = encode(obj)

        assert.are.same(expected, actual)
      end
    )

    it(
      'should encode an object without escaped chars',
      function()
        local expected = [===[{
  "_id\n\": "
5973782bdb9a930533b05cb2\"
}
]===]

        local obj = {
          ['_id\n\\'] = '\n5973782bdb9a930533b05cb2\\'
        }

        local actual = encode(obj, {sort_keys = true, pretty = true, escape_string_values = false})

        assert.are.same(expected, actual)
      end
    )

    it(
      'should encode an object with escaped chars',
      function()
        local expected = [===[{
  "_id\n\": "\n5973782bdb9a930533b05cb2\"
}
]===]

        local obj = {
          ['_id\n\\'] = '\n5973782bdb9a930533b05cb2\\'
        }

        local actual = encode(obj, {sort_keys = true, pretty = true, escape_string_values = true})
        assert.are.same(expected, actual)

        local actual = encode(obj, {sort_keys = true, pretty = true})
        assert.are.same(expected, actual)
      end
    )

    it(
      'should encode an array with object that is not pretty',
      function()
        local expected =
          '[{"_id":"5973782bdb9a930533b05cb2","age":32,"balance":"$1,446.35","company":"ARTIQ","email":"logankeller@artiq.com","eyeColor":"green","favoriteFruit":"banana","friends":[{"id":0,"name":"Colon Salazar"},{"id":1,"name":"French Mcneil"},{"id":2,"name":"Carol Martin"}],"gender":[],"isActive":true,"name":"Logan Keller","phone":"+1 (952) 533-2258"}]\n'

        local obj = {
          {
            ['_id'] = '5973782bdb9a930533b05cb2',
            ['isActive'] = true,
            ['balance'] = '$1,446.35',
            ['age'] = 32,
            ['eyeColor'] = 'green',
            ['name'] = 'Logan Keller',
            ['gender'] = {},
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

        local actual = encode(obj, {sort_keys = true, pretty = false})
        assert.are.same(expected, actual)
      end
    )
  end
)
