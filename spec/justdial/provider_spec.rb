require 'spec_helper'

describe 'Provider' do
  describe 'parse' do
    it 'parses json result into companies' do
      result_json = '{
                        "022PXX22.XX22.130305230010.B3I9":{
                            "companyname":"A Company",
                            "address":"An Address",
                            "city":"A City",
                            "pincode":"555555",
                            "landline":"1234567890",
                            "mobile":"+(91)-1234567890,0987654321",
                            "email":"foo@bar.baz",
                            "website":"http://example.com",
                            "latitude":"19.110092000000",
                            "longitude":"72.943386000000",
                            "avg_rating":"0.0",
                            "total_ratings":0
                        },
                        "022PXX22.XX22.121126154549.E6R3":{
                            "companyname":"Another Company",
                            "address":"Another Address",
                            "city":"Another City",
                            "pincode":"666666",
                            "landline":"22334455",
                            "mobile":"+(91)-11223344,55667788",
                            "email":"bar@baz.boo",
                            "website":"http://anotherexample.com",
                            "latitude":"19.284816000000",
                            "longitude":"72.869389000000",
                            "avg_rating":"3.8",
                            "total_ratings":36
                        }
                      }'
      results = JustDial::Provider.parse(result_json)
      expect(results).to have(2).results
      result_one = results[0]
      expect(result_one.id).to eq('022PXX22.XX22.130305230010.B3I9')
      expect(result_one.companyname).to eq('A Company')
      expect(result_one.address).to eq('An Address')
      expect(result_one.city).to eq('A City')
      expect(result_one.pincode).to eq('555555')
      expect(result_one.landline).to eq('1234567890')
      expect(result_one.mobile).to eq('+(91)-1234567890,0987654321')
      expect(result_one.email).to eq('foo@bar.baz')
      expect(result_one.website).to eq('http://example.com')
      expect(result_one.latitude).to eq('19.110092000000')
      expect(result_one.longitude).to eq('72.943386000000')
      expect(result_one.avg_rating).to eq('0.0')
      expect(result_one.total_ratings).to eq(0)
    end
  end
end