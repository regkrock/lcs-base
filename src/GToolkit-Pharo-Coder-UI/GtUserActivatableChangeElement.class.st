Class {
	#name : #GtUserActivatableChangeElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'activatableChange'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'instance creation' }
GtUserActivatableChangeElement class >> fromActivatableChange: arg1 [
	^ self new activatableChange: arg1
]

{ #category : #'instance creation' }
GtUserActivatableChangeElement >> activatableChange: arg1 [
	self removeChildren.
	activatableChange := arg1.
	self
		addChild: (arg1 hasDiffChange
				ifTrue: [ arg1 change gtDiffChange asElement vFitContent beSmallSize ]
				ifFalse: [ | tmp2 |
					tmp2 := BrLabel new.
					tmp2
						aptitude: BrGlamorousLabelAptitude new;
						text: arg1 change displayString ])
]

{ #category : #initialization }
GtUserActivatableChangeElement >> initialize [
	super initialize.
	self
		hMatchParent;
		vFitContent
]
