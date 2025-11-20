Class {
	#name : 'LcsBasePostCode',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'code'
	],
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsBasePostCode class >> codeSlotDefinition [
	<slotDefinition>
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
