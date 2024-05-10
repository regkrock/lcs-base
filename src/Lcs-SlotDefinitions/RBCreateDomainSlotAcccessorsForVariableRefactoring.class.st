Class {
	#name : #RBCreateDomainSlotAcccessorsForVariableRefactoring,
	#superclass : #RBCreateAccessorsForVariableRefactoring,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> createMatcher [ 
	^ self parseTreeSearcherClass slotGetterMethod: variableName
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> defineGetterMethod [
	self definingClass 
		compile: ('<1s><r><t>^ self getValueOfSlotNamed: ''<2s>''' 
			expandMacrosWith: self selector 
			with: variableName)
		classified: #(#accessing).
	^ selector
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> defineSetterMethod [
	| definingClass string |
	definingClass := self definingClass.
	string := self needsReturnForSetter 
				ifTrue: [ '<1s> anObject<r><t>^ self setValueOfSlotNamed: ''<2s>'' to: anObject' ]
				ifFalse: [ '<1s> anObject<r><t>self setValueOfSlotNamed: ''<2s>'' to: anObject' ].
				
	selector := self safeMethodNameFor: definingClass
				basedOn: variableName asString , ':'.
	definingClass 
		compile: (string expandMacrosWith: selector with: variableName)
		classified: #accessing.
	^ selector
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> findGetterMethod [
	| definingClass matcher |
	definingClass := self definingClass.
	matcher := self createMatcher.
	^ self possibleGetterSelectors
		detect: [ :each |
			(self checkClass: definingClass selector: each using: matcher) notNil
				and: [ (definingClass subclassRedefines: each) not ] ]
		ifNone: [ nil ]
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> findSetterMethod [
	| definingClass matcher |
	definingClass := self definingClass.
	matcher := self needsReturnForSetter
		ifTrue: [ self parseTreeSearcherClass returnSlotSetterMethod: variableName ]
		ifFalse: [ self parseTreeSearcherClass slotSetterMethod: variableName ].
	^ self possibleSetterSelectors
		detect: [ :each | 
			(self checkClass: definingClass selector: each using: matcher) notNil
				and: [ (definingClass subclassRedefines: each) not ] ]
		ifNone: [ nil ]
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> possibleGetterSelectors [
	| method |
	method := [ self definingClass realClass methodNamed: variableName asSymbol ]
			on: KeyNotFound
			do: [ ^ Array new ].

	^ Array with: method selector
]

{ #category : #accessing }
RBCreateDomainSlotAcccessorsForVariableRefactoring >> possibleSetterSelectors [
	| method |
	method := [ self definingClass realClass
			methodNamed: (variableName , ':') asSymbol ]
			on: KeyNotFound
			do: [ ^ Array new ].
	^ Array with: method selector
]
