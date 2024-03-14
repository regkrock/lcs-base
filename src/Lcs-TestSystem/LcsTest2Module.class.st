Class {
	#name : #LcsTest2Module,
	#superclass : #LcsModule,
	#category : #'Lcs-TestSystem'
}

{ #category : #accessing }
LcsTest2Module class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlotDefinition newOn: LcsBaseConfiguration
]

{ #category : #accessing }
LcsTest2Module class >> moduleName [
	^ 'Test 2 Module'
]
