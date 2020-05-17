a = []
b = []
def anagramComp(str1, str2):
	for c in str1:
		a.append(sort(c)) # sort isn't a thing here
	for c in str2:
		b.append(sor(c)) # sort isn't a thing here either
	if a == b:
		print "ANAGRAM"
	else:
		print "This ain't shit"

print anagramComp('car', 'rac')
print anagramComp('race', 'park')