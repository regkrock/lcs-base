Class {
	#name : #LcsStringSlotDefinitionBuilderTest,
	#superclass : #LcsPrimitiveSlotDefinitionBuilderTest,
	#category : #'Lcs-BarebonesSystemTests'
}

{ #category : #tests }
LcsStringSlotDefinitionBuilderTest >> testInstallingFirstNameSlotInPerson [
	| person |
	self slotName: 'firstName'.
	self initialValue: 'John'.
	self targetClass: LxxBarebonesPerson.
	self slotBuilderClass: LcsStringSlotDefinitionBuilder.

	self buildAndInstallNewSlot.
	
	person := self targetClass new perform: self slotSetterName with: self initialValue.
	self assert: (person perform: self slotGetterName) equals: self initialValue
]
