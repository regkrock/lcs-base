Extension { #name : #LcsSystemManagerTest }

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsSystemManagerTest >> testCreation [
	LcsSystemManager releaseEnvironment.
	LcsSystemManager initializeEnvironment.

	LxxBarebonesSystem newSystem.
	self assert: LcsUnitOfWorkManager currentUnitOfWork hasNoChanges.
	self assert: (LcsSystemManager currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: LcsSystemManager currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPerson slotDefinitions hasElements.
	self assert: LcsSystemManager currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration
]

{ #category : #'*Lcs-PrototypeSystemTests' }
LcsSystemManagerTest >> testCreationOfNewSystem [
	LxxBarebonesSystem newSystem.
	self assert: LcsSystemManager currentSystem class identicalTo: LxxBarebonesSystem.
	"self assert: (LcsSystemManager currentSystem slotDefinitionNamed: 'persons' ) notNil.
	self assert: LcsSystemManager currentSystem persons class == LcsSmalltalkConfiguration identitySetClass.
	
	self assert: LxxPerson slotDefinitions hasElements.
	self assert: LcsSystemManager currentSystem configuration class name equals: #LxxBarebonesSystemConfiguration"
]
