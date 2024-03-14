Class {
	#name : #LcsTest1Module,
	#superclass : #LcsModule,
	#category : #'Lcs-TestSystem'
}

{ #category : #accessing }
LcsTest1Module class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsBaseConfiguration
]

{ #category : #accessing }
LcsTest1Module class >> moduleName [
	^ 'Test 1 Module'
]
