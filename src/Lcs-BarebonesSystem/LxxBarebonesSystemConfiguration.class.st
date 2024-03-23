Class {
	#name : #LxxBarebonesSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-BarebonesSystem'
}

{ #category : #accessing }
LxxBarebonesSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: 'parent';
		yourself
]
