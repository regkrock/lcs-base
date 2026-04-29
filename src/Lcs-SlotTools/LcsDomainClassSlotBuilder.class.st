Class {
	#name : 'LcsDomainClassSlotBuilder',
	#superclass : 'LcsSmalltalkObjectSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsDomainClassSlotBuilder >> defaultTypeOfSlotRuleClass [
	^ LcsClassIsMemberSlotTypesRule
]
