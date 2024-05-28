Class {
	#name : #LcsBooleanSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsBooleanSlotDefinitionBuilderTest >> testInstallingBooleanInPerson [
	| person |
	self slotName: 'hasBlueEyes'.
	self initialValue: true.
	self targetClass: LxxBarebonesPerson.
	self slotBuilderClass: LcsBooleanSlotDefinitionBuilder. 
	
	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
