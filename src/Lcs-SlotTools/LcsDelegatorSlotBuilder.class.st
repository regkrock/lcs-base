Class {
	#name : 'LcsDelegatorSlotBuilder',
	#superclass : 'LcsFacadeSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
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
