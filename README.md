 # Hacking Zegermans

A quick and very dirty script to generate good password candidates for password spraying, targeting only german speaking organizations. 

## What does it do?

It uses base words and generates them to German compliant passwords. These generations are customizable and based on some real statistics (around 10k purely German passwords) combined with long hacking experience, from me and various hacking colleagues and friends. This is not the end result of actual high level multiyear university peer-reviewed science - I would never claim that, but it is also not some random consultant influencer crap. Let’s just say that this has so far, a good and long proven record of working.  

## How does it work?

### Non thinking edition
```
git clone https://github.com/rootcathacking/zegermans
cd zegermans
bash zegermans.sh 3
```
This takes the words from *words.txt* and generates 3 variants each and stores them in the file *german_passwords.txt*. You then take this file and give it to the password spraying script of your choice. E.g. [Credmaster](https://github.com/knavesec/CredMaster).
If you want some leet speak variations just use *"--leet|-l]"*.


### Thinking edition

The base words get a suffix number and a special character at the end. The typical German company compliance password is usually structured like this *Aaaaaa2024!*. So, a base word, capitalized first character, lower rest character followed by a number/year and then a special character. Keep in mind password spraying does not try to find the most secure password, but rather the weakest ones used by most people, while still being compliant and not actively on a deny list. 

Speaking of deny list or blocked passwords, this is the reason why the words.txt do not contain for example *Password1!*, or *QWERTY1!* and the likes, as these are usually not allowed any more due to enterprise constraints. Entra-ID has a weird metric on this but usually does not allow these and does sometimes not allow the name of the company, or the name of the registered domain. 

So, company names can be allowed, or they might not be. Usually, I would go with what is here *Sommer*, *Winter* etc. and then go for the places and city names the company operates from, change them per target. 

Per default the script uses *8* character minimum, if you know it is *12* for your target, change the value in line 42. 

Per default the script uses the suffixes set in line 24. Namely: *"2025" "2024" "1" "123"*. They are usually fine, if you need more but still stay German typical you can look at the ones in line 43 and use them instead, which add *"0815" "96" "88" "04"*. Or change it to what you already know has a realistic chance of being there. If you have no idea, just use what is there.

Per default the script does not use all special characters equally, because users do not either. In most cases, in reality, it will be just a *"!"*. You can change the weights of these symbols in line 28. 

Per default just the words in *words.txt* are used, which you can of course freely change. Depending on how your password spraying setup is (lockouts, tries, time etc.), you can also have a look at the files *words_medium.txt* and *words_long.txt* for inspiration.




