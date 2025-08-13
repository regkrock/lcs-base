Class {
	#name : #LcsVirtualSlotBuilder,
	#superclass : #LcsBaseSlotBuilder,
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsVirtualSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
	^ LcsVirtualSlot
]

{ #category : #'job steps' }
LcsVirtualSlotBuilder >> buildJobSteps [
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterMethodBuilder
]

{ #category : #'job steps' }
LcsVirtualSlotBuilder >> getterMethodBuilder [
	^ LcsSlotGetterBuilder new
		slotName: self slotName;
		targetClassName: self targetClassName;
		yourself
]
