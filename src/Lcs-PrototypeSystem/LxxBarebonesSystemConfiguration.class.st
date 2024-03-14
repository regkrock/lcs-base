Class {
	#name : #LxxBarebonesSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxBarebonesSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: 'parent';
		yourself
]
