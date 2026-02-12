Class {
	#name : 'LcsBasePostCode',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'code'
	],
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBasePostCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'code';
		yourself
]

{ #category : 'accessing' }
LcsBasePostCode >> code [
	^ self slotVarNamed: 'code'
]

{ #category : 'accessing' }
LcsBasePostCode >> code: anObject [
	self slotVarNamed: 'code' put: anObject
]
