# Hacking Zegermans

A quick and very dirty script to generate good passwords for password spraying, targeting german speaking organisations. 

## What does it do?

It uses base words and generates them to compliant passwords. These generations are customisable and based on some real statistics combined with long hacking expierence, from me and various collegues.

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





```
