"
Here, a title attribute is added to the <p> element. The value of the title attribute will be displayed as a tooltip when you mouse over the paragraph:

It can also be use in other complex widget as the fieldset
"
Class {
	#name : #CSNUITitle,
	#superclass : #CSNAttribute,
	#category : #'Casino-Model-UI-SubEntities-Attributes'
}

{ #category : #accessing }
CSNUITitle >> accept: anExporter [
	^ anExporter visitUITitle: self
]