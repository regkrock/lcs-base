Class {
	#name : #LcsScaledDecimalSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #accessing }
LcsScaledDecimalSlotDefinitionBuilderTest >> testInstallingHeightSlotInPerson [
	| person |
	self slotName: 'height'.
	self initialValue: 180.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsIntegerSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]

{ #category : #accessing }
LcsScaledDecimalSlotDefinitionBuilderTest >> testInstallingWeightSlotInPerson [
	| person |
	self slotName: 'weigth'.
	self initialValue: 180.0s2.
	self targetClass: LxxPrototypePerson.
	self slotBuilderClass: LcsScaledDecimalSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
