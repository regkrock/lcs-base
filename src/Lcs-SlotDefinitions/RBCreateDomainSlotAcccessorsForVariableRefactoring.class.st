Class {
	#name : #RBCreateDomainSlotAcccessorsForVariableRefactoring,
	#superclass : #RBCreateAccessorsForVariableRefactoring,
	#category : #'Lcs-SlotDefinitions'
}

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
