# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Statuses
Status.create( status: "Open")
Status.create( status: "In progress")
Status.create( status: "Closed")

#Severities
Severity.create( severity: "Low", description: "No time frame required")
Severity.create( severity: "Normal", description: "Needs to be fixed soon")
Severity.create( severity: "Urgent", description: "All attention required")

#Locations: 13 GNG
Location.create( short_name: "N/A", name: "Not Applicable")
Location.create( short_name: "AGG", name: "Americus Gas N Go", address1: "202 B Hwy 19 S", city: "Americus", state: "Ga", phone: "12299318940")
Location.create( short_name: "GGE", name: "Gas N Go Express", address1: "110 Hwy 19 S", city: "Americus", state: "Ga", zip: "31719", phone: "12293804745")
Location.create( short_name: "FM1", name: "Food Mart 1", address1: "1042 Mlk Blvd N", city: "Americus", state: "Ga", zip: "31719", phone: "12299283236")
Location.create( short_name: "FM2", name: "Food Mart 2", address1: "1301 E Lamar St", city: "Americus", state: "Ga", zip: "31709", phone: "12299285650")
Location.create( short_name: "FM3", name: "Food Mart 3", address1: "96 S Broad st", city: "Ellaville", state: "Ga", zip: "31806", phone: "12299372989")
Location.create( short_name: "FGG", name: "Fort Valley Gas N Go", address1: "101 Vinevilee", city: "Fort Valley", state: "Ga", zip: "31030", phone: "14788259971")
Location.create( short_name: "PTC", name: "Pinehurst Travel Center", address1: "824 Pinehurst Hawkinsville Rd", city: "Pinehurst", state: "Ga", zip: "31070", phone: "12296453479")
Location.create( short_name: "PFM", name: "Preston Food Mart", address1: "6281 Hamilton St", city: "Preston", state: "Ga", zip: "31824", phone: "12298283425")
Location.create( short_name: "BGG", name: "Byron Gas N Go", address1: "248 GA Hwy 49 N", city: "Byron", state: "Ga", zip: "31008", phone: "14789560822")
Location.create( short_name: "BVGG", name: "Buena Vista Gas N Go", address1: "101 6th Ave E", city: "Buena Vista", state: "Ga", zip: "31803", phone: "12296492918")
Location.create( short_name: "CGG", name: "Cordele Gas N Go", address1: "1815 16th Ave E", city: "Cordele", state: "Ga", zip: "31015", phone: "12292731115")
Location.create( short_name: "CFM", name: "Cusseta Food Mart", address1: "197 US Hwy 520", city: "Cusseta", state: "Ga", zip: "31805", phone: "17069893596")
Location.create( short_name: "MGG", name: "Montezuma Gas N Go", address1: "432 Spalding Rd", city: "Montezuma", state: "Ga", zip: "31063", phone: "14784580052")
Location.create( short_name: "SUBAME", name: "Subway Americus")
Location.create( short_name: "SUBGGE", name: "Subway Express")
Location.create( short_name: "SUBPTC", name: "Subway Pinehurst")
Location.create( short_name: "MPC", name: "Montezuma Perry's Chicken")
Location.create( short_name: "280E", name: "PBO East Office", address1: "125 US-280 W", city: "Americus", state: "Ga", zip: "31719", phone: "12299240306")
Location.create( short_name: "280W", name: "PBO West Office", address1: "207 US-280 W", city: "Americus", state: "Ga", zip: "31719")
Location.create( short_name: "FPTS", name: "Five Points Office")
Location.create( short_name: "FPTSFF", name: "Five Points Fleet Fueling", address1: "98-2 Wanderlodge Way", city: "Fort Valley", state: "GA", zip: "31030")
Location.create( short_name: "CFF", name: "Cordele Fleet Fueling", address1: "302 Midway Rd", city: "Cordele", state: "Ga", zip: "31015")
Location.create( short_name: "STRIP280", name: "Striplings 280", address1: "2470 US-280", city: "Cordele", state: "Ga", zip: "31015", phone: "12292711522")
Location.create( short_name: "STRIP300", name: "Striplings 300", address1: "2289 GA-300 S", city: "Cordele", state: "Ga", zip: "31015", phone: "12295356561")
Location.create( short_name: "WPITT-FF", name: "William Pitts FF", address1: "1010 11th Ave E", city: "Cordele", state: "Ga", zip: "31015")
Location.create( short_name: "HarrisSt", name: "Union Compress", address1: "210 Harris st", city: "Cordele", state: "Ga", zip: "31015")


#Tags
Tag.create( name: "WAN IP")
Tag.create( name: "Serial Number")
Tag.create( name: "LAN IP")

#Manufacturers
Manufacturer.create( name: "Gilbarco Veeder-root")
Manufacturer.create( name: "Wayne")
Manufacturer.create( name: "OPW")
Manufacturer.create( name: "NCR")
Manufacturer.create( name: "Veriphone")
Manufacturer.create( name: "Igenico")

#Equipment
Equipment.create( model: "MX915", manufacturer_id: 5)
Equipment.create( model: "TLS350", manufacturer_id: 1)
Equipment.create( model: "TLS450", manufacturer_id: 1)
Equipment.create( model: "PX60 Passport", manufacturer_id: 1)
Equipment.create( model: "Panther", manufacturer_id: 4)
Equipment.create( model: "Radiant Site Controller", manufacturer_id: 4)

#Roles
Role.create( role: "Administrator")
Role.create( role: "Contributor")
Role.create( role: "Audience")
Role.find_or_create_by!(role: "internal_admin")
Role.find_or_create_by!(role: "internal_user")
Role.find_or_create_by!(role: "external_admin")
Role.find_or_create_by!(role: "external_user")

#Teams
Team.find_or_create_by!(name: "Internal")
Team.find_or_create_by!(name: "External")