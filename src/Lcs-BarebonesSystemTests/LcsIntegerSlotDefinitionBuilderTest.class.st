Class {
	#name : #LcsIntegerSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsIntegerSlotDefinitionBuilderTest >> testInstallingHeightSlotInPerson [
	| person |
	self slotName: 'height'.
	self initialValue: 180.
	self targetClass: LxxBarebonesPerson.
	self slotBuilderClass: LcsIntegerSlotDefinitionBuilder.
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
