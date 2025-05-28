Class {
	#name : #LcsDomainClassAndLocalCollectionClassBuilderJobTest,
	#superclass : #LcsCodeJobBuilderTest,
	#category : #'Lcs-SlotToolsTests-Tests'
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
	self currentCodeBuilderJob execute.
	self assert: self currentSystem invoices notNil.
	self assert: (self currentSystem invoices isKindOf: #LxxInvoices asClass)
]

{ #category : #tests }
LcsDomainClassAndLocalCollectionClassBuilderJobTest >> testCreationOfNewDomainClassAndItsLocalCollectionClassInstalledInAModule [
	| newInvoice newInvoiceItem |
	self createLxxInvoiceAndLxxInvoices.
	self currentCodeBuilderJob:
		(LcsDomainClassAndLocalCollectionClassBuilderJob new
			classPrefix: 'Lxx';
			createForRootName: 'InvoiceItem';
			installNewClassesInPackageNamed: 'Lcs-PrototypeSystem';
			installCollectionSlotInClass: #LxxInvoice asClass;
			buildJobSteps;
			yourself).
	self currentCodeBuilderJob execute.
	
	newInvoice := #LxxInvoice asClass new.

	self assert: newInvoice invoiceItems collectionSize = 0.
	self assert: (newInvoice invoiceItems isKindOf: (#LxxInvoiceItems asClass)).

	self currentSystem applyChanges.

	newInvoiceItem := #LxxInvoiceItem asClass newInContextOf: newInvoice.
	self assert: newInvoiceItem parent == newInvoice invoiceItems.

	self currentSystem applyChanges.

	self assert: (newInvoice invoiceItems includes: newInvoiceItem)
]
