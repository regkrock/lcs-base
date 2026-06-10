Class {
	#name : 'LxxUnknownSkill',
	#superclass : 'LxxSkill',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LxxUnknownSkill class >> skillCodeSlotDefinition [
	<accessorSlotDefinition>
	^ super skillCodeSlotDefinition
		initialValueBlock: [ :parentDomainObject :slot | 'unknown' ]
]
