Class {
	#name : #CSNUICWAutoComplete,
	#superclass : #CSNUIInput,
	#category : #'Casino-Model-CoreWeb-Entities'
}

{ #category : #meta }
CSNUICWAutoComplete class >> annotation [

	<MSEClass: #AutoComplete super: #CSNUIInput>
	<package: #'Casino-Model-CoreWeb'>
	<generated>
	^self
]

{ #category : #'as yet unclassified' }
CSNUICWAutoComplete >> getExternalDependency [
	^ {PNGAutoComplete}
]

{ #category : #'as yet unclassified' }
CSNUICWAutoComplete >> getSelector [
	^ 'p-autoComplete'
]