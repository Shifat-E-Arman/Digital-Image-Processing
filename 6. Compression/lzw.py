given_string = "BABAABAAA"
s = given_string[0]
diction = []
for c in given_string:
    if c not in diction:
        diction.append(c)
output = []
for characters in given_string[1:]:
    c = characters
    if s + c in diction:
        s = s + c
    else:
        #         print(diction.index(s))
        output.append(diction.index(s))
        diction.append(s + c)
        s = c
# print(diction.index(s))
output.append(diction.index(s))
print(output)
print(diction)
