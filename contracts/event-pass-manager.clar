;; event-pass-manager.clar
;; A smart contract for digital event pass management with comprehensive capabilities for creating,
;; revoking, and reassigning digital passes. This contract implements a secure ownership system
;; with role-based access controls and batch operations support.
;;
;; Core capabilities:
;; - Role-based management of event passes with owner privileges
;; - Single and bulk pass issuance with metadata support
;; - Pass revocation and transfer with ownership verification
;; - Comprehensive tracking of pass status and history
;; - Extensive query functions for pass verification and management

;; Core system constants
(define-constant contract-owner tx-sender)  ;; The entity with administrative rights
(define-constant err-unauthorized-access (err u200))  ;; Permission denied error code
(define-constant err-unauthorized-holder (err u201))  ;; Unauthorized holder error code
(define-constant err-pass-data-invalid (err u202))  ;; Invalid pass data error code
(define-constant err-pass-not-available (err u203))  ;; Pass not found error code
(define-constant err-revocation-failed (err u204))  ;; Pass revocation failure code
(define-constant err-previously-revoked (err u205))  ;; Already revoked error code
(define-constant bulk-issuance-limit u50)  ;; Maximum passes in a single bulk operation

;; Primary data structures
(define-non-fungible-token digital-pass uint)  ;; NFT representing an event pass
(define-data-var current-pass-count uint u0)  ;; Counter for issued passes

;; Data storage mappings
(define-map pass-information uint (string-ascii 128))  ;; Information storage for each pass
(define-map revoked-passes uint bool)  ;; Registry of revoked passes
(define-map bulk-issuance-records uint (string-ascii 128))  ;; Records for bulk issuance operations

;; Internal helper functions

(define-private (check-revocation-status (pass-id uint))
    ;; Determines if a pass has been previously revoked
    (default-to false (map-get? revoked-passes pass-id)))


