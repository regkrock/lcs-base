Class {
	#name : #LcsBooleanSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsBooleanSlotDefinitionBuilderTest >> testInstallingBooleanInPerson [
	| person |
	self slotName: 'hasBlueEyes'.
	self initialValue: true.
	self targetClass: LxxPerson.
	self slotBuilderClass: LcsBooleanSlotDefinitionBuilder. 
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue.
	self assert: (person hasBlueEyes) equals: self initialValue
]
