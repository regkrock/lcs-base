Class {
	#name : #GtRefactoringsElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'activatableRefactorings',
		'changesElement'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Refactorings'
}

{ #category : #accessing }
GtRefactoringsElement >> applyRefactoringWithProgress: arg1 [
	^ changesElement applyChangesWithProgress: arg1
]

{ #category : #accessing }
GtRefactoringsElement >> applyRefactorings [
	^ changesElement applyChanges
]

{ #category : #accessing }
GtRefactoringsElement >> changes: arg1 [
	changesElement changes: arg1
]

{ #category : #accessing }
GtRefactoringsElement >> changesSize [
	^ changesElement changes changesSize
]

{ #category : #initialization }
GtRefactoringsElement >> initialize [
	super initialize.
	self
		layout: BlLinearLayout vertical;
		matchParent;
		padding: (BlInsets all: 10).
	changesElement := GtChangesElement new.
	self
		addAptitude: (BrLayoutResizerAptitude new inherit: changesElement);
		addChild: changesElement
]

{ #category : #accessing }
GtRefactoringsElement >> refactorings: arg1 [
	| tmp1 |
	arg1 isEmpty ifTrue: [ ^ self ].
	tmp1 := arg1 first model changes.
	self changes: tmp1
]
