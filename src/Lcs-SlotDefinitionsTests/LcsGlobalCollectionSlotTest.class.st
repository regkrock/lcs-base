"
The purpose of this class is test Global Colleciton Slot where it has not installed.
"
Class {
	#name : #LcsGlobalCollectionSlotTest,
	#superclass : #LcsWithPrototypeSystemSetUpForTest,
	#instVars : [
		'codeJobBuilder'
	],
	#category : #'Lcs-SlotDefinitionsTests-Tests'
}

{ #category : #tests }
LcsGlobalCollectionSlotTest >> testDefaultCreation [
	self subject: LcsGlobalCollectionSlot new.
	self assert: self subject slotTypes isEmpty.
	self assert: self subject collectionMemberTypes isEmpty.
	self assert: self subject collectionClass = IdentitySet.
	self assert: self subject slotName isNil.
	self assert: self subject parent isNil.
	self assert: self subject isNotRequired .
	self
		assert: self subject initialValueBlock asString
		equals: '[ :parentDomainObject :slotDefinition | slotDefinition newObjectWithParent: parentDomainObject ]'.
	self assert: (self subject validator isKindOf: LcsConditionsValidator)
]
