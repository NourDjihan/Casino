Extension { #name : #BLAttribute }

{ #category : #'*BL-Model-Exporter-Angular' }
BLAttribute >> = anotherAttribute [
	^ self class = anotherAttribute class
]

{ #category : #'*BL-Model-Exporter-Angular' }
BLAttribute >> asString [
	^ self leftToken  , self name , self rightToken ,'="' , self attributeValue , '"'
]

{ #category : #'*BL-Model-Exporter-Angular' }
BLAttribute >> leftToken [
	^ ''
]

{ #category : #'*BL-Model-Exporter-Angular' }
BLAttribute >> rightToken [
	^ ''
]