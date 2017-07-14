# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias OpenFootyBase.Repo
alias OpenFootyBase.Team
alias OpenFootyBase.Ground

adelaide_oval = Repo.insert!(%Ground{ name: "Adelaide Oval", initial: "AO", state: "South Australia" })
Repo.insert!(%Ground{ name: "University of Tasmania Stadium", initial: "US", state: "Tasmania" })
Repo.insert!(%Ground{ name: "Blundstone Arena", initial: "BA", state: "Tasmania" })
Repo.insert!(%Ground{ name: "Cazalys Stadium", initial: "CS", state: "Queensland" })
domain = Repo.insert!(%Ground{ name: "Domain Stadium", initial: "DS", state: "Western Australia" })
etihad = Repo.insert!(%Ground{ name: "Etihad Stadium", initial: "ES", state: "Victoria" })
gabba = Repo.insert!(%Ground{ name: "The Gabba", initial: "G", state: "Queensland" })
Repo.insert!(%Ground{ name: "Jiangwan Stadium", initial: "JS", state: "China" })
Repo.insert!(%Ground{ name: "UNSW Canberra Oval", initial: "MO", state: "Canberra" })
Repo.insert!(%Ground{ name: "Mars Stadium", initial: "EU", state: "Victoria" })
mcg = Repo.insert!(%Ground{ name: "MCG", initial: "MCG", state: "Victoria" })
metricon = Repo.insert!(%Ground{ name: "Metricon Stadium", initial: "MS", state: "Queensland" })
scg = Repo.insert!(%Ground{ name: "SCG", initial: "SCG", state: "New South Wales" })
simonds = Repo.insert!(%Ground{ name: "Simonds Stadium", initial: "SS", state: "Victoria" })
spotless = Repo.insert!(%Ground{ name: "Spotless Stadium", initial: "SPO", state: "New South Wales" })
Repo.insert!(%Ground{ name: "TIO Stadium", initial: "TIO", state: "Northern Territory" })
Repo.insert!(%Ground{ name: "TIO Traeger Park", initial: "TP", state: "Northern Territory" })

Repo.insert!(%Team{ name: "Adelaide", nickname: "Crows", home_ground: adelaide_oval })
Repo.insert!(%Team{ name: "Brisbane", nickname: "Lions", home_ground: gabba })
Repo.insert!(%Team{ name: "Carlton", nickname: "Blues", home_ground: mcg })
Repo.insert!(%Team{ name: "Collingwood", nickname: "Pies", home_ground: mcg })
Repo.insert!(%Team{ name: "Essendon", nickname: "Bombers", home_ground: etihad })
Repo.insert!(%Team{ name: "Fremantle", nickname: "Dockers", home_ground: domain })
Repo.insert!(%Team{ name: "Geelong", nickname: "Cats", home_ground: simonds })
Repo.insert!(%Team{ name: "Gold Coast", nickname: "Suns", home_ground: metricon })
Repo.insert!(%Team{ name: "Greater Western Sydney", nickname: "Giants", home_ground: spotless })
Repo.insert!(%Team{ name: "Hawthorn", nickname: "Hawks", home_ground: mcg })
Repo.insert!(%Team{ name: "Melbourne", nickname: "Demons", home_ground: mcg })
Repo.insert!(%Team{ name: "North Melbourne", nickname: "Kangaroos", home_ground: etihad })
Repo.insert!(%Team{ name: "Port Adelaide", nickname: "Power", home_ground: adelaide_oval })
Repo.insert!(%Team{ name: "Richmond", nickname: "Tigers", home_ground: mcg })
Repo.insert!(%Team{ name: "St. Kilda", nickname: "Saints", home_ground: etihad })
Repo.insert!(%Team{ name: "Sydney", nickname: "Swans", home_ground: scg })
Repo.insert!(%Team{ name: "West Coast", nickname: "Eagles", home_ground: domain })
Repo.insert!(%Team{ name: "Western Bulldogs", nickname: "Dogs", home_ground: etihad })
