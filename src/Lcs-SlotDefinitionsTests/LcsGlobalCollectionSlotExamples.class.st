"
The purpose of this class is test Global Colleciton Slot where it has not installed.
"
Class {
	#name : 'LcsGlobalCollectionSlotExamples',
	#superclass : 'LcsPrototypeSystemRunningTest',
	#instVars : [
		'codeJobBuilder'
	],
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsGlobalCollectionSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsGlobalCollectionSlot new.
	self assert: slot slotTypes isEmpty.
	self assert: slot collectionMemberTypes isEmpty.
	self assert: slot collectionClass = IdentitySet.
	self assert: slot slotName isNil.
	self assert: slot parent isNil.
	self assert: slot isNotRequired.
	self
		assert: slot initialValueBlock asString
		equals: '[ :parentDomainObject :slot | slot newObjectWithParent: parentDomainObject ]'.
	^ slot
]
