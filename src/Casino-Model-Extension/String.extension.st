Extension { #name : #String }

{ #category : #'*Casino-Model-Extension' }
String >> onlyNumbers [
	"answer the receiver with only letters
	'23azs54as' onlyNumbers  "

	^ self select: [ :each | each isDigit ]
]
