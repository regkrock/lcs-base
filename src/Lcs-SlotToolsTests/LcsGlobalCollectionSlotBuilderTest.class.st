Class {
	#name : #LcsGlobalCollectionSlotBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlotBuilderTest >> tearDown [
	^ super tearDown
]

{ #category : #tests }
LcsGlobalCollectionSlotBuilderTest >> testInstallingGlobalCollectionSlot [
	self subject: (
		LcsGlobalCollectionSlotBuilder new
			slotName: 'foos';
			targetClassName: LxxPrototypeSystem name;
			targetModuleClass: LxxPrototypeSystem name;
			collectionMemberTypes: (OrderedCollection with:  LxxPerson name );
			addSlotType: LxxPersons name ;
			yourself).
	self subject buildJobSteps.
	self subject installCode.
	self subject verifyCodeInstallation
]
