Extension { #name : #CSNWidget }

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> actionsTag [
	^ self actions
		flatCollect: [ :actionAppel | ' ' , actionAppel getAngularRepresentation ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> angularComponent [
	^ WidgetRepresentation
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> attributesTagWith: anExporter [
	^ (self computeSelfAttributes flattened groupedBy: #name) asDictionary
		associationsDo: [ :mapAttributeNameValues | 
			anExporter
				<<< ' ';
				<<< mapAttributeNameValues key;
				<<< '="'.
			mapAttributeNameValues value asOrderedCollection do: [ :attribute | anExporter visit: attribute ] separatedBy: [ anExporter <<< ' ' ].
			anExporter <<< '"' ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> computeSelfAttributes [
	^ {self attributes. self getPositionAttribute. {self generateDefaultClassAttribute}. self containedElementAttribute } flattened asOrderedCollection 
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> containedElementAttribute [
	^ self container ifNil: [ {  } ] ifNotNil: [ :a | a hierarchalAttributes ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> container [
	^ self cellOwner ifNil: [ self widgetContainer ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> exportAttribute: normalyOneOfMyWidget with: anExporter [
	self angularComponent exportAttribute: normalyOneOfMyWidget with: anExporter
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> generateDefaultClassAttribute [
	"Use me to add a Attribute to all the widget during the exportation
	ex: Adding a class to all the dom with the name of the widget"
	^ CSNUIClass new attributeValue: ('ID-', self class name asString). 
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> getExternalDependencies [
	^ {self getExternalDependency.
	self getExternalDependency collect: #internalDependencies}
		flattened
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> getExternalDependency [
	^ { self angularComponent }
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> getListPropertiesAsStringWith: anExporter [
	anExporter <<< self getSelector.
	self angularComponent componentAttributeOn: anExporter forWidget: self.
	anExporter <<< self actionsTag.
	anExporter <<< self idTag
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> getPositionAttribute [
	^ self position
		ifNotNil: [ CSNUIStyle new
				name: 'style';
				attributeValue: self position angularValue;
				yourself ]
		ifNil: [ {} ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> getSelector [
	^ self angularComponent getSelector
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> gtInAngular: composite [
	<gtInspectorPresentationOrder: 1005>
	composite text
		title: 'Angular HTML';
		display: [ String streamContents: [ :s | (CSNModelExporterAngular on: s) visit: self ] ];
		withLineNumbers: true;
		when: [ self isPageMetier not and: [ (self isKindOf: CSNPage) not ] ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> hierarchalAttributes [ 
	^ {  }
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> id [
	| dic |
	dic := self rootNode
		cacheAt: #widgetUniqueName
		ifAbsentPut: [ {(self -> self variable name)} asDictionary ].
	^ dic
		at: self
		ifAbsentPut: [ | index potentialName |
			index := 0.
			potentialName := self variable name.
			[ dic includes: potentialName ]
				whileTrue: [ potentialName := (potentialName removeSuffix: index asString)
						, (index + 1) asString.
					index := index + 1 ].
			potentialName ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> idTag [
	^ self variable ifNil: [ '' ] ifNotNil: [ ' #' , self id ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> idViewChild [
	^ (self variable isNil or: [ self variable isInvocation ])
		  ifTrue: [ '' ]
		  ifFalse: [ 
			  '    @ViewChild(''' , self id , ''', { static: false}) ' , self id , ': '
			  , self angularComponent moduleName , ';' , String crlf ]
]

{ #category : #'*Casino-Model-Exporter-Angular' }
CSNWidget >> isPageMetier [
	^ false
]
