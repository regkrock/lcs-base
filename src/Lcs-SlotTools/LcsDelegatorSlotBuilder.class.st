Class {
	#name : 'LcsDelegatorSlotBuilder',
	#superclass : 'LcsFacadeSlotBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'configuration' }
LcsDelegatorSlotBuilder class >> slotClass [
	^ LcsDelegatorSlot
]

{ #category : 'job steps' }
LcsDelegatorSlotBuilder >> buildJobSteps [
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : 'job steps' }
LcsDelegatorSlotBuilder >> slotDefinitionMethodBuilder [
	^ super slotDefinitionMethodBuilder
			beFacadeSlot;
			yourself
]
