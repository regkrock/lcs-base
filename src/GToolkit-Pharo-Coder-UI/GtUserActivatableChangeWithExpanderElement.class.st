Class {
	#name : #GtUserActivatableChangeWithExpanderElement,
	#superclass : #GtUserActivatableChangeElement,
	#instVars : [
		'expander',
		'header',
		'description',
		'checkbox'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'instance creation' }
GtUserActivatableChangeWithExpanderElement >> activatableChange: arg1 [
	| tmp1 |
	activatableChange ifNotNil: [ activatableChange announcer unsubscribe: self ].
	activatableChange := arg1.
	activatableChange announcer weak
		when: #enablementChanged
		send: #onEnablementChanged
		to: self.
	activatableChange isEnabled
		ifTrue: [ checkbox check ]
		ifFalse: [ checkbox uncheck ].
	tmp1 := activatableChange change displayString.
	activatableChange change changesSize > 1
		ifTrue: [ tmp1 := tmp1 asRopedText
					, ((' (' , activatableChange change changesSize printString , ' changes)')
							asRopedText foreground: BrGlamorousColors disabledHeaderTextColor) ].
	description text: tmp1.
	expander
		content: [ activatableChange hasDiffChange
				ifTrue: [ | tmp3 |
					tmp3 := GtDiffElement onChange: activatableChange change gtDiffChange.
					tmp3
						styler: activatableChange change gtDiffStyler;
						aptitude: GtDiffFlatAptitude;
						vFitContent;
						beSmallSize ]
				ifFalse: [ | tmp5 |
					tmp5 := BrLabel new.
					tmp5
						beSmallSize;
						aptitude: BrGlamorousLabelAptitude new;
						text: tmp1 ] ].
	activatableChange isExpanded
		ifTrue: [ expander expand ]
		ifFalse: [ expander collapse ]
]

{ #category : #initialization }
GtUserActivatableChangeWithExpanderElement >> initialize [
	| tmp2 tmp4 tmp6 tmp8 tmp10 |
	super initialize.
	expander := BrExpander new.
	tmp2 := GtCoderExpanderAptitude new.
	tmp2
		cornerRadius: 3;
		padding: BlInsets empty.
	tmp4 := BrStyleCommonAptitude new.
	tmp4
		expanded: [ :arg1 | 
			arg1
				margin: (BlInsets
						top: 5
						left: 5
						bottom: 5
						right: 5) ].
	expander
		aptitude: tmp2 doNotReplaceHeader
				+ (tmp4
						collapsed: [ :arg2 | 
							arg2
								margin: (BlInsets
										top: 5
										left: 5
										bottom: 0
										right: 5) ]);
		hMatchParent;
		vFitContent;
		whenExpandedDo: [ activatableChange isExpanded: true ];
		whenCollapsedDo: [ activatableChange isExpanded: false ].
	tmp6 := BrVerticalPane new.
	tmp6
		hMatchParent;
		vFitContent.
	header := tmp6 alignCenterLeft.
	tmp8 := BrLabel new.
	tmp8
		aptitude: BrGlamorousLabelAptitude;
		padding: (BlInsets left: 5 right: 5);
		hMatchParent;
		vFitContent.
	description := tmp8 beSmallSize.
	header addChildren: {description}.
	tmp10 := BrCheckbox new.
	tmp10
		beSmallSize;
		aptitude: BrGlamorousCheckboxAptitude new;
		margin: (BlInsets top: 6);
		whenCheckedDo: [ activatableChange isEnabled: true ].
	checkbox := tmp10 whenUncheckedDo: [ activatableChange isEnabled: false ].
	expander header: [ header ].
	self
		addChildren: {checkbox.
				expander}
]

{ #category : #'event handling' }
GtUserActivatableChangeWithExpanderElement >> onEnablementChanged [
	activatableChange isEnabled
		ifTrue: [ checkbox check ]
		ifFalse: [ checkbox uncheck ]
]
