Class {
	#name : #GtAdvice,
	#superclass : #Object,
	#instVars : [
		'priorAdvice',
		'creator',
		'name',
		'description',
		'priority',
		'actions'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Object Advices'
}

{ #category : #accessing }
GtAdvice class >> adviceFor: arg1 [
	| tmp1 |
	tmp1 := self advicePragmasFor: arg1.
	^ ((tmp1 collect: [ :arg2 | arg2 methodSelector ]) asSet
		collect: [ :arg3 | arg1 perform: arg3 with: self none ])
		asSortedCollection: [ :arg4 :arg5 | arg4 priority < arg5 priority ]
]

{ #category : #accessing }
GtAdvice class >> adviceForClass: arg1 [
	| tmp1 |
	tmp1 := self adviceFor: arg1 instanceSide.
	tmp1 addAll: (self adviceFor: arg1 classSide).
	^ tmp1
]

{ #category : #accessing }
GtAdvice class >> advicePragmasFor: arg1 [
	^ Pragma
		allNamed: #gtAdvice
		from: arg1 class
		to: ProtoObject
]

{ #category : #'instance creation' }
GtAdvice class >> none [
	^ GtNoAdvice new
]

{ #category : #'instance creation' }
GtAdvice class >> on: arg1 [
	| tmp2 |
	tmp2 := self new.
	tmp2 priorAdvice: arg1.
	^ tmp2 yourself
]

{ #category : #accessing }
GtAdvice >> action: arg1 [
	self
		actions: [ :arg2 | 
			| tmp1 |
			(tmp1 := arg1 cull: arg2) ifNil: [ #() ] ifNotNil: [ {tmp1} ] ]
]

{ #category : #accessing }
GtAdvice >> actions [
	^ actions
]

{ #category : #accessing }
GtAdvice >> actions: arg1 [
	actions := arg1
]

{ #category : #advice }
GtAdvice >> asyncStream [
	^ GtAsyncStreamAdvice on: self
]

{ #category : #ui }
GtAdvice >> buildActions: arg1 in: arg2 for: arg3 [
	| tmp2 |
	arg1 isEmpty ifTrue: [ ^ self ].
	tmp2 := BrSimpleList new.
	tmp2
		stencil: [ :arg4 | 
			| tmp3 tmp5 tmp7 |
			tmp5 := BrHorizontalPane new.
			tmp5
				hMatchParent;
				vFitContent;
				addAptitude: (BrStyleCommonAptitude new
							hovered: [ :arg5 | arg5 background: arg3 theme button defaultBorderColor ]);
				padding: (BlInsets all: 5);
				when: BlClickEvent
					do: [ :arg6 | 
							arg6 consumed: true.
							arg4 executeOn: arg3.
							arg3
								fireEvent: BrDropdownHideWish new;
								fireEvent: BrContextMenuHideWish new ].
			tmp7 := BrLabel new.
			tmp7
				aptitude: BrGlamorousLabelAptitude;
				text: arg4 title glamorousCodeSmallSize.
			tmp3 := tmp5 addChild: tmp7 yourself.
			tmp3 ];
		hMatchParent;
		vFitContentLimited.
	arg2 addChild: (tmp2 items: arg1)
]

{ #category : #ui }
GtAdvice >> buildElementFor: arg1 [
	| tmp1 tmp3 tmp4 tmp5 |
	tmp1 := BrVerticalPane new.
	tmp1
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 5 bottom: 5).
	self
		resultsDo: [ :arg2 | 
			| tmp11 |
			tmp3 := (self descriptionFor: arg2) asRopedText
					foreground: BrGlamorousColors disabledButtonTextColor.
			creator
				ifNotNil: [ | tmp7 |
					tmp7 := GtButtonAttribute new.
					tmp7 beAppend.
					tmp5 := tmp7
							stencil: [ | tmp9 |
								tmp9 := BrButton new.
								tmp9
									aptitude: BrGlamorousButtonWithIconAptitude new;
									beTinySize;
									margin: (BlInsets left: 5);
									icon: BrGlamorousVectorIcons browse;
									action: [ arg1 phlow spawnTool: (GtMethodCoderTool compiledMethod: creator) ];
									label: 'Browse rule definition' ].
					tmp3
						attribute: tmp5
						from: tmp3 size
						to: tmp3 size ].
			tmp11 := BrEditor new.
			tmp11
				vFitContent;
				aptitude: BrGlamorousRegularEditorAptitude new glamorousCodeSmallSize.
			tmp4 := tmp11 text: tmp3.
			tmp1 addChild: tmp4.
			self
				buildActions: (actions cull: arg2)
				in: tmp1
				for: arg1 ].
	^ tmp1
]

{ #category : #accessing }
GtAdvice >> creator [
	^ creator
]

{ #category : #accessing }
GtAdvice >> description [
	^ description
]

{ #category : #accessing }
GtAdvice >> description: arg1 [
	description := arg1
]

{ #category : #accessing }
GtAdvice >> descriptionFor: arg1 [
	^ description cull: arg1
]

{ #category : #testing }
GtAdvice >> hasAdvice [
	^ false
]

{ #category : #initialization }
GtAdvice >> initialize [
	super initialize.
	priority := SmallInteger maxVal.
	actions := [ :arg1 | #() ]
]

{ #category : #advice }
GtAdvice >> item [
	^ GtItemAdvice on: self
]

{ #category : #advice }
GtAdvice >> list [
	^ GtListAdvice on: self
]

{ #category : #advice }
GtAdvice >> none [
	^ GtNoAdvice on: self
]

{ #category : #accessing }
GtAdvice >> priorAdvice [
	^ priorAdvice
]

{ #category : #accessing }
GtAdvice >> priorAdvice: arg1 [
	priorAdvice := arg1.
	self setCreator
]

{ #category : #accessing }
GtAdvice >> priority [
	^ priority
]

{ #category : #accessing }
GtAdvice >> priority: arg1 [
	priority := arg1
]

{ #category : #accessing }
GtAdvice >> result [
	^ nil
]

{ #category : #enumerating }
GtAdvice >> resultsDo: arg1 [
	
]

{ #category : #private }
GtAdvice >> setCreator [
	| tmp1 tmp2 |
	tmp1 := thisContext.
	[ tmp1 notNil ]
		whileTrue: [ tmp2 := tmp1 method pragmas.
			(tmp2 anySatisfy: [ :arg1 | arg1 selector = #gtAdvice ])
				ifTrue: [ ^ creator := tmp1 method ].
			tmp1 := tmp1 sender ]
]
