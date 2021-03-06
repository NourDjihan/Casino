Class {
	#name : #CSNModelImporterCoreWebPostOfficeVisitor,
	#superclass : #CSNModelImporterCoreWebVisitor,
	#category : #'Casino-Migration-PostOffice'
}

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUIInputDate: aCSNUIInputDate [
  ^(#('BLTextBoxDate' 'BLTextBoxDatePicker' 'DatePicker' 'ThotTextBoxDatePicker') includes: source invokedClassName) ifTrue: [ (self createWidgetInput: aCSNUIInputDate)
           addAttribute: ((self create: CSNUIPlaceholder) attributeValue: (source parameters at: 1 ifAbsent: [ '' ]));
           yourself ] ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUILink: aCSNUILink [
	^ ('BLLinkLabel' = source invokedClassName or: [ source isInvocation and: [ source signature beginsWith: 'createBLLinkLabel' ] ])
		ifTrue: [ (self createWidget: aCSNUILink) 
			addAttribute:
			((self create: CSNUILabel)
				attributeValue:
					(source parameters ifNotEmpty: [ :parameters | parameters first ] ifEmpty: [ 'todo' ]));
				yourself ] 
		
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUIPanel: aCSNUIPanel [
	^ ((#('BLImageUploadPanel' 'BLFileUploadPanel' 'TabSubPanel' 'ThotDeckSidePanel' 'TabPanel') includes: source invokedClassName) not
		and: [ (#('FlexTable' 'BLFlexTable' 'BLGrid' 'Grid') includes: source invokedClassName) or: [ source invokedClassName endsWith: 'Panel' ] ])
		ifTrue: [ self createWidgetPanel: aCSNUIPanel ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUIParagraph: aCSNUIParagraph [
	^ (#('BLLabel' 'Label' 'FactoryBLLabel' 'ComponentUtils' 'InlineLabel' 'BLLabelItem') includes: source invokedClassName)
		ifTrue: [ | paragraph |
			paragraph := self createWidget: aCSNUIParagraph.
			'ComponentUtils' = source invokedClassName
				ifTrue: [ self attributeFor: paragraph fromComponentUtilsForInvocation: source ]
				ifFalse: [ paragraph
						addAttribute: ((self create: CSNUILabel) attributeValue: (source parameters at: 1 ifAbsent: [ '' ]));
						addAttribute:
							((self create: CSNUIClass)
								attributeValue:
									((source parameters size = 2
										ifTrue: [ ((source parameters at: 2) prefixMatchesRegex: 'BLLabel\..*') ifTrue: [ source parameters at: 2 ] ifFalse: [ 'NIVEAU2' ] ]
										ifFalse: [ source parameters at: 3 ifAbsent: [ 'NIVEAU2' ] ]) removePrefix: 'BLLabel.')) ].
			paragraph ]
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUISelect: aCSNUISelect [
	^ (#('BLListBox' 'ListBox' 'BLMultiCombo' 'BLThotListBox') includes: source invokedClassName) 
		ifTrue: [ self createWidgetInput: aCSNUISelect ] 
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUITab: aCSNUITab [
	^ ('ThotSideBarItem' = source invokedClassName) 
		ifTrue: [ (self createWidget: aCSNUITab) ] 
		ifFalse: [ nil ]
]

{ #category : #visitor }
CSNModelImporterCoreWebPostOfficeVisitor >> visitCSNUITabManager: aCSNUITabManager [
	^ (#('TabSubPanel' 'ThotDeckSidePanel' 'TabPanel') includes: source invokedClassName) 
		ifTrue: [ (self createWidget: aCSNUITabManager) ] 
		ifFalse: [ nil ]
]
