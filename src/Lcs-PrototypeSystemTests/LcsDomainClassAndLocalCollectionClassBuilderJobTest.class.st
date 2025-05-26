Class {
	#name : #LcsDomainClassAndLocalCollectionClassBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #private }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> createLxxInvoiceAndLxxInvoices [
	self currentCodeBuilderJob:
		(LcsDomainClassAndGlobalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'Invoice';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute
]

{ #category : #tests }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> testCreationOfNewDomainClassAndItsLocalCollectionClassInstalledInAModule [
	self createLxxInvoiceAndLxxInvoices.
	self currentCodeBuilderJob:
		(LcsDomainClassAndLocalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'InvoiceItem';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: LxxPrototypeSystem;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute
]
