Class {
	#name : #GtPharoProcessCoderElement,
	#superclass : #GtPharoMethodsCoderElement,
	#instVars : [
		'activeCoder',
		'contextVariablesElement',
		'watchVariablesElement',
		'watchExpressions'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! Views'
}

{ #category : #private }
GtPharoProcessCoderElement >> addMethodWatchExpressionFrom: arg1 [
	GtWatchExpression addExpression: arg1 selectedSource for: arg1 compiledMethod.
	self updateWatchExpressions
]

{ #category : #private }
GtPharoProcessCoderElement >> addWatchExpressionFrom: arg1 [
	(watchExpressions at: arg1 ifAbsentPut: [ OrderedCollection new ])
		add: (GtWatchExpression new expression: arg1 selectedSource).
	self updateWatchExpressions
]

{ #category : #ui }
GtPharoProcessCoderElement >> buildElement [
	super buildElement.
	self
		layout: BlLinearLayout horizontal;
		addChild: self variablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> contextVariables [
	| tmp1 |
	(activeCoder isNil or: [ activeCoder isDead ]) ifTrue: [ ^ #() ].
	tmp1 := OrderedCollection new.
	activeCoder
		tempNamesAndValuesDo: [ :arg1 :arg2 | 
			tmp1
				add: {arg1.
						'temporary'.
						arg2} ];
		instanceVariableNamesAndValuesDo: [ :arg3 :arg4 | 
				tmp1
					add: {arg3.
							'instance'.
							arg4} ].
	tmp1
		sort: [ :arg5 :arg6 | arg5 first < arg6 first ];
		addFirst: {'self'.
					'self'.
					activeCoder receiver}.
	activeCoder
		stackVariableNamesAndValuesDo: [ :arg7 :arg8 | 
			tmp1
				add: {arg7.
						'stack'.
						arg8} ].
	^ tmp1
]

{ #category : #ui }
GtPharoProcessCoderElement >> contextVariablesElement [
	contextVariablesElement := self variablesListElement.
	contextVariablesElement items: self contextVariables.
	^ contextVariablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> focusedCoder: arg1 in: arg2 [
	activeCoder := arg1.
	self updateVariables
]

{ #category : #'initialize-release' }
GtPharoProcessCoderElement >> initialize [
	super initialize.
	watchExpressions := WeakKeyDictionary new
]

{ #category : #private }
GtPharoProcessCoderElement >> updateList [
	super updateList.
	self updateVariables
]

{ #category : #private }
GtPharoProcessCoderElement >> updateVariables [
	contextVariablesElement notNil
		ifTrue: [ contextVariablesElement display: self contextVariables ].
	self updateWatchExpressions
]

{ #category : #private }
GtPharoProcessCoderElement >> updateWatchExpressions [
	watchVariablesElement notNil
		ifTrue: [ watchVariablesElement display: self watchVariables ]
]

{ #category : #ui }
GtPharoProcessCoderElement >> variablesElement [
	| tmp2 tmp4 tmp6 |
	tmp2 := BrTabGroup new.
	tmp2 aptitude: BrGlamorousTabGroupAptitude new.
	tmp4 := BrTab new.
	tmp4
		aptitude: BrGlamorousTabAptitude new;
		label: 'Variables'.
	tmp2 addTab: (tmp4 stencil: [ self contextVariablesElement ]).
	tmp6 := BrTab new.
	tmp6
		aptitude: BrGlamorousTabAptitude new;
		label: 'Watches'.
	^ tmp2 addTab: (tmp6 stencil: [ self watchVariablesElement ])
]

{ #category : #ui }
GtPharoProcessCoderElement >> variablesListElement [
	| tmp1 tmp3 tmp8 tmp12 |
	tmp1 := BrColumnedList new.
	tmp1
		margin: (BlInsets all: 10);
		addEventHandler: (GtPhlowListToSelectHandler new transformation: [ :arg1 | arg1 last ]).
	tmp3 := tmp1 column.
	tmp3
		title: 'Icon';
		stencil: [ :arg2 | 
				| tmp4 |
				tmp4 := [ | tmp6 |
					tmp6 := arg2 last gtInspectorIcon.
					tmp6 ifNil: [ arg2 last class systemIcon ] ifNotNil: [ tmp6 ] ]
						on: Error
						do: [ :arg3 | self iconNamed: #smallWarningIcon ].
				tmp4 asElement
					margin: (BlInsets
							top: 3
							left: 10
							bottom: 3
							right: 0) ].
	tmp8 := tmp1 column.
	tmp8
		title: 'Variable';
		stencil: [ :arg4 | 
				| tmp10 |
				tmp10 := BrLabel new.
				tmp10
					aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
					text: arg4 first asString;
					hMatchParent;
					vMatchParent;
					margin: (BlInsets
								top: 3
								left: 10
								bottom: 3
								right: 0) ].
	tmp12 := tmp1 column.
	tmp12
		title: 'Value';
		stencil: [ :arg5 | 
				| tmp14 |
				tmp14 := BrLabel new.
				tmp14
					aptitude: (BrGlamorousLabelAptitude new foreground: Color black);
					text: (arg5 last printStringLimitedTo: 50);
					hMatchParent;
					vMatchParent;
					margin: (BlInsets
								top: 3
								left: 10
								bottom: 3
								right: 0) ].
	^ tmp1
]

{ #category : #private }
GtPharoProcessCoderElement >> watchExpressionsFor: arg1 [
	^ (watchExpressions at: arg1 ifAbsent: [ #() ])
		, (GtWatchExpression expressionsFor: arg1 compiledMethod) asArray
]

{ #category : #private }
GtPharoProcessCoderElement >> watchVariables [
	| tmp1 |
	tmp1 := OrderedCollection new.
	methodsCoderUIModel coder coders
		do: [ :arg1 | tmp1 addAll: (self watchVariablesFor: arg1) ].
	^ tmp1
]

{ #category : #ui }
GtPharoProcessCoderElement >> watchVariablesElement [
	watchVariablesElement := self variablesListElement.
	watchVariablesElement items: self watchVariables.
	^ watchVariablesElement
]

{ #category : #private }
GtPharoProcessCoderElement >> watchVariablesFor: arg1 [
	^ (self watchExpressionsFor: arg1)
		collect: [ :arg2 | 
			{arg2 expression.
				'Watch Expression'.
				arg2 valueIn: arg1 context} ]
]
