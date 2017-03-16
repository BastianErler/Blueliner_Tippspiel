# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             guest: true,
             activated_at: Time.zone.now)

Team.create!(name:  'Augsburger Panther',
             team_logo: 'team_AUG.png')

Team.create!(name:  'Fischtown Pinguins Bremerhaven',
             team_logo: 'team_BHV.png')

Team.create!(name:  'Düsseldorfer EG',
             team_logo: 'team_DEG.png')

Team.create!(name:  'Eisbären Berlin',
             team_logo: 'team_EBB.png')

Team.create!(name:  'Iserlohn Roosters',
             team_logo: 'team_IEC.png')

Team.create!(name:  'ERC Ingolstadt',
             team_logo: 'team_ING.png')

Team.create!(name:  'Kölner Haie',
             team_logo: 'team_KEC.png')

Team.create!(name:  'Krefeld Pinguine',
             team_logo: 'team_KEV.png')

Team.create!(name:  'Adler Mannheim',
             team_logo: 'team_MAN.png')

Team.create!(name:  'EHC Red Bull München',
             team_logo: 'team_MUC.png')

Team.create!(name:  'Thomas Sabo IceTigers',
             team_logo: 'team_NIT.png')

Team.create!(name:  'Straubingen Tigers',
             team_logo: 'team_STR.png')

Team.create!(name:  'Schwenninger Wild Wings',
             team_logo: 'team_SWW.png')

Team.create!(name:  'Grizzlys Wolfsburg',
             team_logo: 'team_WOB.png')
