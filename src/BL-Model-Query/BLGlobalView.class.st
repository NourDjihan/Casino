Class {
	#name : #BLGlobalView,
	#superclass : #Object,
	#category : 'BL-Model-Query-RoassalGlobal'
}

{ #category : #'view creation' }
BLGlobalView >> legend: b [
	| lb |
	lb := RTLegendBuilder new.
	lb view: b view.
	lb left.
	lb textSize: 30.
	lb addText: 'Legende'.
	lb addColor: BLPhase color text: 'Phase'.
	lb addColor: BLWidget color text: 'Widget'.
	lb addColor: BLPageMetier color text: 'Page Metier'.
	lb addLineColor: Color gray text: 'Contain'.
	lb addLineColor: Color blue text: 'Link action'.
	lb build
]

{ #category : #'view creation' }
BLGlobalView >> openViewForModel: aBLModel [
	| b |
	b := RTMondrian new.
	b shape circle color: [ :cl | cl color ].
	b nodes: aBLModel allBLPhase , aBLModel allBLWidget , aBLModel allBLService.
	(b shape line arrowedLine headOffset: 1.0) shape head
		baseSize: 5.0;
		size: 8.
	(b shape line arrowedLine
		headOffset: 1.0;
		color: [ :e | 
			((e key isKindOf: BLWidget) and: [ e value isKindOf: BLPhase ])
				ifTrue: [ Color blue ]
				ifFalse: [ Color gray ] ]) shape head
		baseSize: 5.0;
		size: 8.
	b edges useAssociations: ((aBLModel allBLPhase collect: #allAssociations) , (aBLModel allBLWidget collect: #allAssociations)) flatten.
	b layout force strength: 0.4.
	b view pushBackEdges.
	self legend: b.
	^ b
]