accessing
viewReferencesToWidgetInterface
	| view nodes references lb tmpNode |
	nodes := self modelWidget asSet
		select: [ :class |  class isInterface ] .
	references := nodes
		flatCollect: [ :a | 
			((a queryIncoming: FAMIXInvocation) atScope: FAMIXClass)
				collect: [ :b | Association new key: b value: a ]
				thenReject: [ :b | self modelWidget includes: b key ] ].
	nodes addAll: self appTools modelPhases.
	nodes addAll: self appTools modelPageMetier.
	view := RTMondrian new.
	view shape rectangle
		color: [ :cl | 
			(self isClassFromWidget: cl)
				ifTrue: [ Color green ]
				ifFalse: [ Color orange ] ];
		width: [ :cl | (references select: [ :b | b value = cl ]) size ].
	"view nodes: nodes asSet."
	tmpNode := references
		select: [ :a | (nodes includes: a key) and: [ nodes includes: a value ] ].
	view
		nodes:
			{(tmpNode collect: #key).
			(tmpNode collect: #value)} flatten asSet.
	(view shape line arrowedLine headOffset: 1.0) shape head
		baseSize: 5.0;
		size: 8.
	view edges useAssociations: references.
	view layout sugiyama.
	lb := RTLegendBuilder new.
	lb
		view: view view;
		right.
	lb addText: 'Legende'.
	lb addColor: Color green text: 'Widget'.
	lb addColor: Color orange text: 'Other Class (from BlApp)'.
	lb addLineColor: Color gray text: 'refer to'.
	lb build.
	^ view