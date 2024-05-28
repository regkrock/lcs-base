Class {
	#name : #GtUserActivatableChange,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'change',
		'changes',
		'refactoring',
		'isEnabled',
		'isExpanded'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #'instance creation' }
GtUserActivatableChange class >> fromChange: arg1 [
	^ self new fromChange: arg1
]

{ #category : #accessing }
GtUserActivatableChange >> allChanges [
	^ {self} , (self changes flatCollect: #allChanges)
]

{ #category : #accessing }
GtUserActivatableChange >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ] ifNotNil: [ announcer ]
]

{ #category : #converting }
GtUserActivatableChange >> asElement [
	^ self elementClass fromActivatableChange: self
]

{ #category : #accessing }
GtUserActivatableChange >> change [
	^ change
]

{ #category : #accessing }
GtUserActivatableChange >> changes [
	<return: #Collection of: #GtUserActivatableChange>
	^ changes
]

{ #category : #converting }
GtUserActivatableChange >> elementClass [
	^ GtUserActivatableChangeWithExpanderElement
]

{ #category : #'instance creation' }
GtUserActivatableChange >> fromChange: arg1 [
	change := arg1.
	changes := change gtChildren collect: [ :arg2 | self class fromChange: arg2 ].
	isEnabled := true
]

{ #category : #testing }
GtUserActivatableChange >> hasDiffChange [
	^ self change respondsTo: #gtDiffChange
]

{ #category : #initialization }
GtUserActivatableChange >> initialize [
	super initialize.
	isEnabled := false.
	isExpanded := false
]

{ #category : #testing }
GtUserActivatableChange >> isChange [
	^ true
]

{ #category : #accessing }
GtUserActivatableChange >> isEnabled [
	^ isEnabled
]

{ #category : #accessing }
GtUserActivatableChange >> isEnabled: arg1 [
	isEnabled = arg1 ifTrue: [ ^ self ].
	isEnabled := arg1.
	self onEnablementStateChanged.
	changes do: [ :arg2 | arg2 isEnabled: arg1 ]
]

{ #category : #accessing }
GtUserActivatableChange >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
GtUserActivatableChange >> isExpanded: arg1 [
	isExpanded := arg1
]

{ #category : #testing }
GtUserActivatableChange >> isRefactoring [
	^ false
]

{ #category : #private }
GtUserActivatableChange >> onEnablementStateChanged [
	announcer ifNotNil: [ announcer announce: #enablementChanged ]
]

{ #category : #printing }
GtUserActivatableChange >> printOn: arg1 [
	arg1 print: self change
]
