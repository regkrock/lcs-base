Class {
	#name : 'LcsGuestUser',
	#superclass : 'LcsBaseUser',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsGuestUser class >> passwordSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGuestPasswordSlot new
]
