Extension { #name : #BLUIGridLayout }

{ #category : #'*BL-Model-Exporter-Angular' }
BLUIGridLayout >> getSelector [
	^ 'table'
]

{ #category : #'*BL-Model-Exporter-Angular' }
BLUIGridLayout >> specificSelector [ 
	^ true
]

{ #category : #'*BL-Model-Exporter-Angular' }
BLUIGridLayout >> tdAttributeForCell: aCell [
	"return as String because it is super specific to Grid"
	| cellPosition |
	cellPosition := ((self privateState attributeAt: #cellPosition ifAbsentPut: [ Dictionary new ]) at: aCell).
	^ ''
		,
			(((self privateState attributeAt: #cellVerticalSpan ifAbsentPut: [ Dictionary new ]) select: [ :param | param first = cellPosition first and: [ param second = cellPosition second ] ]) flatCollect: [ :verticalSpan | ' rowspan="' , verticalSpan third asString , '" ' ])
		,
			(((self privateState attributeAt: #cellHorizontalSpan ifAbsentPut: [ Dictionary new ]) select: [ :param | param first = cellPosition first and: [ param second = cellPosition second ] ]) flatCollect: [ :verticalSpan | ' colspan="' , verticalSpan third asString , '" ' ])
]